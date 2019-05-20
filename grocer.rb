def consolidate_cart(cart)
  uniq_cart = cart.uniq
  answer = {}
  uniq_cart.each {|uni_item|
    uni_item.each {|item_name, chars|
      answer[item_name] = chars
      chars[:count] = cart.count(uni_item)
    }
  }
  return answer
end

def apply_coupons(cart, coupons)
  if coupons.length == 0
    return cart
  end
  answer = {}
  coupons.each {|coupon|
    cart.each {|item, chars|
      answer[item] = chars
      if coupon[:item] == item && chars[:count] >= coupon[:num]
        answer[item][:count] = chars[:count] - coupon[:num]
        if not answer.has_key?(item + " W/COUPON")
          answer[item + " W/COUPON"] = {price: coupon[:cost], clearance: chars[:clearance], count: 1 }
        else
          answer[item + " W/COUPON"][:count] += 1
        end
      end
    }
  }
  return answer
end

def apply_clearance(cart)
  cart.each {|item, chars|
    if chars[:clearance]
      chars[:price] = (chars[:price]*0.8).round(2)
    end
  }
  return cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each {|item, chars|
    total = total + chars[:price]*chars[:count]
  }
  if total > 100
    total = total*0.9
  end
  return total
end
