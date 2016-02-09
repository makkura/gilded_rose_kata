require 'forwardable'
require_relative 'item.rb'

def update_quality(items)
  items.each do |item|
    item = EnhancedItem.new(item)

    case item.type
      when :normal
        # Normal items decrease in quality each day by 1 until their sell date then decrease by 2
        # Minimum quality is 0
        item.quality = (item.sell_in > 0 ? item.quality - 1 : item.quality - 2)
        item.quality = 0 unless item.quality >= 0

        item.sell_in -= 1
      when :conjured
        # Conjured items decrease in quality each day by 2 until their sell date then decrease by 4
        # Minimum quality is 0
        item.quality = (item.sell_in > 0 ? item.quality - 2 : item.quality - 4)
        item.quality = 0 unless item.quality >= 0

        item.sell_in -= 1
      when :legendary
        # I am legendary and am immune to your pricing schemes!
      when :aged
        # Aged items increase in quality by 1 each day until their sell date then they increase by 2
        # Maximum quality is 50
        item.quality = (item.sell_in > 0 ? item.quality + 1 : item.quality + 2)
        item.quality = 50 unless item.quality <= 50

        item.sell_in -= 1
      when :backstage
        # Backstage passes increase in quality by 1 until 10 days before the concert
        # Less than 10 days out they increase by 2 until 5 days out
        # Less than 5 days out they increase by 3 until the concert is over
        # After the concert they have no value
        # Maximum quality is 50
        if item.sell_in > 10
          item.quality += 1
        elsif item.sell_in > 5
          item.quality += 2
        elsif item.sell_in > 0
          item.quality += 3
        else
          item.quality = 0
        end
        item.quality = 50 unless item.quality <= 50

        item.sell_in -= 1
    end
  end
end

class EnhancedItem
  # Forwardable used for delegate of item
  # http://ruby-doc.org/stdlib-2.0.0/libdoc/forwardable/rdoc/Forwardable.html
  extend Forwardable
  def_delegators :@item, :name, :sell_in, :quality, :sell_in=, :quality=

  attr_accessor :type

  def initialize(item)
    @item = item

    if name =~ /Aged Brie/i
      @type = :aged
    elsif name =~ /Backstage/i
      @type = :backstage
    elsif name =~ /sulfuras/i
      @type = :legendary
    elsif name =~ /conjured/i
      @type = :conjured
    else
      @type = :normal
    end
  end

  # Methods for specific type checks
  def normal?
    return (@type == :normal ? true : false)
  end
  def legendary?
    return (@type == :legendary ? true : false)
  end
  def conjured?
    return (@type == :conjured ? true : false)
  end
  def aged?
    return (@type == :aged ? true : false)
  end
  def backstage?
    return (@type == :backstage ? true : false)
  end
end