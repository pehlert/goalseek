module GoalSeek
  class LinearSearch
    # block is an f(x) function
    def initialize(f)
      @f = f
    end

    def seek(goal, options = {})
      @goal = goal.to_f

      options = {
          tolerance: 0,
          max_iterations: 1000
      }.merge(options)

      min_max = get_min_max(options[:lower_bound], options[:upper_bound])
      lower, upper = min_max[0], min_max[1]

      iterate(lower, upper, options[:tolerance], options[:max_iterations])
    end

    def iterate(lower, upper, tolerance, max_iterations, iterations = 1)
      new_bound = (lower + upper) / 2

      begin
        new_value = @f.call(new_bound)
      rescue NoMethodError
        raise InvalidFunctionError
      end

      if iterations == max_iterations || new_value === @goal
        return new_bound
      elsif new_value < @goal
        return iterate(new_bound, upper, tolerance, max_iterations, iterations + 1)
      elsif new_value > @goal
        return iterate(lower, new_bound, tolerance, max_iterations, iterations + 1)
      end
    end

    def get_min_max(a, b)
      # Use given bounds if present
      if a && b
        x = a.to_f
        y = b.to_f

        if check_bounds(x, y)
          [x, y]
        elsif check_bounds(y, x)
          [y, x]
        else
          raise InvalidBoundError
        end
      end

      # Try exponential bound expansion from 0 to 10^10
      (0..10).each do |i|
        if check_bounds(0.0, 10.0 ** i)
          return [0.0, 10.0 ** i]
        end
      end

      # Try exponential bound expansion from -x to x
      (0..10).each do |i|
        if check_bounds(-10.0 ** i, 10.0 ** i)
          return [-10.0 ** i, 10.0 ** i]
        end
      end

      # Fall back to raising if no working bound could be found
      raise InvalidBoundError
    end

    def check_bounds(x, y)
      (@f.call(x) < @goal) && (@f.call(y) > @goal) || (@f.call(y) < @goal) && (@f.call(x) > @goal)
    end
  end
end
