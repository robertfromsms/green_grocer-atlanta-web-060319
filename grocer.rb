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
      if coupon[:item] == item
        answer[item][:count] = chars[:count] - coupon[:num]
        answer[item + " W/COUPON"] = {price: coupon[:cost], clearance: chars[:clearance], count: 1 }
      end
    }
  }
  coupons.uniq.each {|uni_coupon|
    if cart.has_key?(uni_coupon[:item])
      answer[uni_coupon[:item] + " W/COUPON"][:count] = coupons.count(uni_coupon)
    end
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
  # code here
end
