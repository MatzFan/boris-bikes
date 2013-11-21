    module BikeContainer

      DEFAULT_CAPACITY = 10

      def bikes
        @bikes ||= []
      end

      def capacity
        @capacity ||= DEFAULT_CAPACITY
      end

      def capacity=(value)
        @capacity = value
      end

      def bike_count
        bikes.count
      end

      def dock(bike)
        if !full?
          bikes << bike if bike.respond_to? :break
        end
      end

      def dock_all(bikes)
        puts bikes.inspect
        bikes.each do |bike|
          puts bike
          dock(bike)
        end
      end

      def release_a_working_bike
        bikes.delete(available_bikes.pop) if available_bikes.count > 0
      end

      def release_a_broken_bike
        bikes.delete(broken_bikes.pop) if broken_bikes.count > 0
      end

      def release_all_working_bikes
        available_bikes.map { |bike| release_a_working_bike }
      end

      def release_all_broken_bikes
        broken_bikes.map { |bike| release_a_broken_bike }
      end

      def full?
        bike_count == capacity
      end

      def empty?
        bike_count == 0
      end

      def available_bikes
        bikes.reject {|bike| bike.broken? }
      end

      def broken_bikes
        bikes.reject {|bike| !bike.broken? }
      end

    end
