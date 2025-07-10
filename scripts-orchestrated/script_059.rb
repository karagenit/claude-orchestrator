def tower_hanoi(n, source = 'A', destination = 'C', auxiliary = 'B')
  return [] if n <= 0
  
  moves = []
  
  def hanoi_recursive(n, source, destination, auxiliary, moves)
    if n == 1
      moves << "Move disk 1 from #{source} to #{destination}"
    else
      hanoi_recursive(n - 1, source, auxiliary, destination, moves)
      moves << "Move disk #{n} from #{source} to #{destination}"
      hanoi_recursive(n - 1, auxiliary, destination, source, moves)
    end
  end
  
  hanoi_recursive(n, source, destination, auxiliary, moves)
  moves
end

def tower_hanoi_count(n)
  return 0 if n <= 0
  (2 ** n) - 1
end

def tower_hanoi_iterative(n, source = 'A', destination = 'C', auxiliary = 'B')
  return [] if n <= 0
  
  moves = []
  total_moves = tower_hanoi_count(n)
  
  pegs = { source => [], destination => [], auxiliary => [] }
  
  (n).downto(1) do |disk|
    pegs[source] << disk
  end
  
  if n.odd?
    target_order = [source, destination, auxiliary]
  else
    target_order = [source, auxiliary, destination]
  end
  
  (1..total_moves).each do |move_num|
    if move_num.odd?
      smallest_peg = pegs.min_by { |_, stack| stack.empty? ? Float::INFINITY : stack.last }[0]
      target_peg = target_order[(target_order.index(smallest_peg) + 1) % 3]
      
      if pegs[smallest_peg].empty?
        disk = pegs[target_peg].pop
        pegs[smallest_peg].push(disk)
        moves << "Move disk #{disk} from #{target_peg} to #{smallest_peg}"
      else
        disk = pegs[smallest_peg].pop
        pegs[target_peg].push(disk)
        moves << "Move disk #{disk} from #{smallest_peg} to #{target_peg}"
      end
    else
      non_smallest_pegs = pegs.select { |peg, stack| stack.empty? || stack.last != 1 }
      
      peg1, peg2 = non_smallest_pegs.keys.first(2)
      
      if pegs[peg1].empty?
        disk = pegs[peg2].pop
        pegs[peg1].push(disk)
        moves << "Move disk #{disk} from #{peg2} to #{peg1}"
      elsif pegs[peg2].empty?
        disk = pegs[peg1].pop
        pegs[peg2].push(disk)
        moves << "Move disk #{disk} from #{peg1} to #{peg2}"
      elsif pegs[peg1].last < pegs[peg2].last
        disk = pegs[peg1].pop
        pegs[peg2].push(disk)
        moves << "Move disk #{disk} from #{peg1} to #{peg2}"
      else
        disk = pegs[peg2].pop
        pegs[peg1].push(disk)
        moves << "Move disk #{disk} from #{peg2} to #{peg1}"
      end
    end
  end
  
  moves
end