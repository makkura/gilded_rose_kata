# The Gilded Rose Code Kata

This is a Ruby version of the Gilded Rose Kata, found
[here](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/).

I have based mine off a ruby version with rspec tests found [here](https://github.com/jimweirich/gilded_rose_kata).

**This is a completed solution. If you are looking for an incomplete one to add to, please look over the links above.**

## The Changes And Why I Chose Them
### Item
I moved the Item definition to its own file and wrote it as an actual class with identical functionality.
This matches the original C# kata this is based from and moves it off to another file, sort of by itself.

### EnhancedItem
I chose to implement the EnhancedItem class to add some flexibility to the requirement of being unable to the Item class directly.

I was introduced to delegates for this project.
This lets me fall back on the exisiting properties and methods of the original item without implementing equivalents in the EnhancedItem class.  I also get to use the EnhancedItem without assigning results to the original Item by hand.

The **type** property is the key feature the EnhancedItem class provides.
This lets me decide what logic each item should be checked against without all the repeated name checking in the original.
It also makes it easy to add new items to existing categories or add new categories like the conjured item added for this implementation.

The specific type check methods are a logical following of this though they do not get used in the example here.
I admit they're mostly an excuse to impliment a legendary method.

### Update Quality
The primary change her is moving from nested if then statements to a switch case.
This allows each type of item to be addressed individually without mixing in the logic of other item types.

The item quality is updated based around the sell_in date using a ternary so if the logic of an item type needs to change how fast the quality changes, it's a small edit to do so.

The maximum and minimum quality checks are handled after the quality is updated.
This both avoids a series of checks before the assignment to be sure it doesn't go out of bounds and allows minimal editing per item type in case the project requirements were to change.

### RSpec File
The rspec file has been updated to use expect statements instead of should statements.

I also added an expected result to check against for backstage passes at maximum quality (line 108) as it appeared to be missing.
