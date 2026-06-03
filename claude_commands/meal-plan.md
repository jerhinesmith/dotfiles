# Whole Foods Meal Plan Generator

Generate meal ideas based on what's currently on sale at Whole Foods. Adapts to what the user asks for.

**Arguments:** $ARGUMENTS

## Pantry & Garden (always on hand -- never put these on the shopping list)

The user keeps these stocked at all times. Do NOT include them on shopping lists, do NOT recommend sale items that duplicate these, and DO build meals that take advantage of them:

- **Lemons/lemon juice** -- has a lemon tree, unlimited supply
- **Olive oil & avocado oil**
- **Rice** -- white and brown, multiple varieties
- **Quinoa** -- almost always on hand; cooks in ~15 min, so it works as a base even for same-day meals (faster than brown rice)
- **Dried beans & lentils** -- black beans, pinto, chickpeas, lentils, etc. (NOTE: these are DRIED and require soaking + cooking. Lentils ~30 min; beans ~3 hrs. NEVER suggest beans for lunch or "tonight" -- only for future dinners, meal prep, or "this week" plans with lead time. Lentils are the only same-day option. Bean dishes also usually need aromatics the user does NOT keep stocked -- celery, carrots, white onion -- so add those to the shopping list when planning a bean meal.)
- **Basic spices** -- salt, pepper, cumin, smoked paprika, chili powder, oregano, garlic powder, onion powder, cinnamon
- **Garlic & onions**
- **Soy sauce / tamari**
- **Vinegars** -- red wine, balsamic, rice

Since the user has abundant beans/lentils, rice, and quinoa, lean into those as bases and side dishes. This means sale-item proteins and vegetables are the real value -- prioritize those on the shopping list.

## Step 1: Interpret the request

Parse `$ARGUMENTS` to determine what to generate. Examples:

| Input | Interpretation | Find recipes? |
|-------|---------------|---------------|
| *(empty)* | 5-day lunch + dinner plan (default) | **YES** (default) |
| `dinner` | 1 dinner idea | No |
| `lunch` | 1 lunch idea | No |
| `3 dinners` | 3 dinner ideas | **YES** (multi-meal default) |
| `dinner for 4` | 1 dinner idea scaled for 4 servings | No |
| `weeknight dinners` | 5 quick weeknight dinner ideas | **YES** (multi-meal default) |
| `meal prep` | Batch-cook friendly plan for the week | **YES** (default) |
| `snacks` | Snack ideas from sale items | No |
| Any other text | Use your best judgment based on what they asked for | See rules below |

**Recipe search rules:**
- **Multi-day/multi-meal requests** (3+ meals, full week, meal prep): search for recipes by default
- **Single meal requests** (1 dinner, 1 lunch): do NOT search unless the user explicitly asks (e.g., "lunch and find a recipe", "dinner with a recipe", "dinner recipe")
- **Explicit override:** keywords like "recipe", "find a recipe", "NYT", "nytimes" always trigger recipe search regardless of meal count. Keywords like "quick", "simple", "no recipe" suppress it.

Scale the shopping list to match -- 1 meal = small list, full week = full list.

## Step 2: Fetch the current sales flyer

Run this command to fetch and parse the current Whole Foods sales flyer:

```bash
curl -s --compressed 'https://www.wholefoodsmarket.com/sales-flyer?store-id=10548' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36' \
  | python3 -c "
import sys, json, re
html = sys.stdin.read()
m = re.search(r'<script[^>]*id=\"__NEXT_DATA__\"[^>]*>(.*?)</script>', html, re.DOTALL)
if not m:
    print('ERROR: Could not find __NEXT_DATA__ in page')
    sys.exit(1)
data = json.loads(m.group(1))
pp = data['props']['pageProps']
result = {
    'store': pp.get('storeName', 'Unknown'),
    'storeId': pp.get('storeId', ''),
    'salePeriod': {
        'start': pp['promotions'][0]['startDate'][:10] if pp.get('promotions') else None,
        'end': pp['promotions'][0]['endDate'][:10] if pp.get('promotions') else None,
    },
    'promotions': [{
        'name': p.get('productName', ''),
        'brand': p.get('originBrandName', ''),
        'regularPrice': p.get('regularPrice', ''),
        'salePrice': p.get('salePrice', ''),
        'primePrice': p.get('primePrice', ''),
        'category': p.get('promotionGrouping', ''),
        'tier': p.get('tier', ''),
    } for p in pp.get('promotions', [])]
}
print(json.dumps(result, indent=2))
"
```

## Step 3: Filter for DASH/Mediterranean diet compatibility

From the sale items, identify items that fit a DASH/Mediterranean diet:

**Prioritize:**
- Fish and seafood (salmon, shrimp, tinned fish)
- Poultry (chicken thighs, drumsticks, chicken sausage)
- Fresh vegetables (asparagus, broccoli, brussels sprouts, sweet potatoes)
- Fresh fruits (avocados, mangoes, lemons, apples, berries)
- Whole grains (brown rice, oats)
- Legumes and plant protein (tempeh)
- Nuts, seeds, dates
- Olive oil, avocado oil, pesto
- Herbs and seasonings (especially over salt)

**Limit or skip:**
- Processed meats (ham, bacon) -- unless turkey bacon in moderation
- Refined carbs (biscuits, croissants, angel food cake)
- High-sodium prepared foods
- Sugary items (chocolate, cookies, gummies)
- Mac & cheese, nuggets
- Alcohol (mention wines if on sale but don't build meals around them)

## Step 4: Find NYT Cooking recipes (when applicable)

**Skip this step entirely if recipe search is not triggered** (see Step 1 rules).

When recipe search IS triggered, use the top 3-5 DASH/Mediterranean-compatible sale proteins and vegetables from Step 3 as search terms.

For each key sale item, use WebSearch to search:

```
site:cooking.nytimes.com [sale item name]
```

For example, if salmon and asparagus are on sale:
- `site:cooking.nytimes.com salmon`
- `site:cooking.nytimes.com asparagus`

**From the search results:**
1. Pick 1-2 recipes per key sale item that look like good fits (DASH/Mediterranean, practical cook time, uses pantry staples the user has)
2. Present each recipe as: **Recipe name** -- [link] -- brief description of why it's a good match (which sale items it uses, estimated time)
3. For multi-day plans, aim for variety across recipes (don't pick 3 salmon recipes)
4. Interleave recipe-based meals with your own generated meal ideas -- not every meal needs a NYT recipe

**Important:** The user has a NYT Cooking subscription, so linking directly to recipes is fine. Do NOT attempt to fetch or reproduce the full recipe text -- just provide the link and a summary. The user will open it in their browser.

## Step 5: Generate meal ideas

**Constraints for all output:**
1. **Variety** -- don't repeat the same protein across meals; mix fish, poultry, and plant-based
2. **Use sale items as the star** -- supplement with common pantry staples (olive oil, garlic, onions, spices) that don't need to be on the list
3. **Keep it practical** -- meals should be achievable in 30-45 min for a home cook
4. **Batch-friendly** -- when generating multiple meals, note where leftovers can carry over

**For a single meal:** Give 2-3 options to choose from, each with a brief description and the key sale items it uses.

**For multi-day plans:** Lay out a day-by-day plan with specific meals. If Step 4 found NYT Cooking recipes, weave them into the plan alongside your own ideas. Mark recipe-based meals with a link so the user can open them. Not every meal needs a recipe -- mix recipe meals with simple generated ideas.

## Step 6: Generate the shopping list

Output a shopping list with:
- Only items from the sale flyer (checked boxes)
- Approximate quantities scaled to the number of meals
- Prime price where available
- Estimated total cost

Format as a markdown checklist grouped by department (Proteins, Produce, Pantry).

## Step 7: Suggest non-sale staples (only if truly needed)

The user has a well-stocked pantry (see "Pantry & Garden" section above). Only mention non-sale items if the recipe requires something unusual that a home cook likely does NOT have on hand (e.g., miso paste, tahini, fish sauce, coconut milk, fresh herbs beyond basics). Skip the obvious staples entirely.
