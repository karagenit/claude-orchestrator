def coin_change(coins, amount)
  return 0 if amount == 0
  return -1 if coins.empty? || amount < 0
  
  dp = Array.new(amount + 1, Float::INFINITY)
  dp[0] = 0
  
  (1..amount).each do |i|
    coins.each do |coin|
      if coin <= i && dp[i - coin] != Float::INFINITY
        dp[i] = [dp[i], dp[i - coin] + 1].min
      end
    end
  end
  
  dp[amount] == Float::INFINITY ? -1 : dp[amount]
end

def coin_change_ways(coins, amount)
  return 1 if amount == 0
  return 0 if coins.empty? || amount < 0
  
  dp = Array.new(amount + 1, 0)
  dp[0] = 1
  
  coins.each do |coin|
    (coin..amount).each do |i|
      dp[i] += dp[i - coin]
    end
  end
  
  dp[amount]
end

def coin_change_with_coins(coins, amount)
  return { min_coins: 0, combination: [] } if amount == 0
  return { min_coins: -1, combination: [] } if coins.empty? || amount < 0
  
  dp = Array.new(amount + 1, Float::INFINITY)
  parent = Array.new(amount + 1, -1)
  dp[0] = 0
  
  (1..amount).each do |i|
    coins.each do |coin|
      if coin <= i && dp[i - coin] != Float::INFINITY
        if dp[i - coin] + 1 < dp[i]
          dp[i] = dp[i - coin] + 1
          parent[i] = coin
        end
      end
    end
  end
  
  if dp[amount] == Float::INFINITY
    { min_coins: -1, combination: [] }
  else
    combination = []
    current = amount
    while current > 0
      coin = parent[current]
      combination << coin
      current -= coin
    end
    { min_coins: dp[amount], combination: combination.sort }
  end
end