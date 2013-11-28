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
        bikes.each { |bike| dock(bike) if !full? }
      end

      def release_a_working_bike
        bikes.delete(available_bikes.pop) if available_bikes.count > 0
      end

      def release_a_broken_bike
        bikes.delete(broken_bikes.pop) if broken_bikes.count > 0
      end

      def release_working_bikes(number)
        released_bikes = []
        number.times do
          released_bikes << release_a_working_bike
          return released_bikes if available_bikes.empty?
        end
        released_bikes
      end

      def release_broken_bikes(number)
        released_bikes = []
        number.times do
          released_bikes << release_a_broken_bike
          return released_bikes if broken_bikes.empty?
        end
        released_bikes
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
        bikes.select {|bike| bike.broken? }
      end

      def bike_spaces
        capacity - bike_count
      end

    end
