    require './lib/bike_container'

    class ContainerHolder; include BikeContainer; end

    describe BikeContainer do

      let(:bike) { Bike.new }
      let(:bikes) {[Bike.new, Bike.new]}
      let(:holder) { ContainerHolder.new }

      def fill_holder(container)
        container.capacity.times { container.dock(Bike.new) }
      end

      it "should accept a bike" do
        expect(holder.bike_count).to eq(0)
        holder.dock(bike)
        expect(holder.bike_count).to eq(1)
      end

      it "should accept multiple bikes" do
        expect(holder.bike_count).to eq(0)
        holder.dock_all(bikes)
        expect(holder.bike_count).to eq(2)
      end

      it "should release a working bike, if it has one" do
        holder.dock(bike)
        expect(holder.release_a_working_bike).to eq(bike)
      end

      it "should not release a working bike, if has none" do
        bike.break
        holder.dock(bike)
        expect(holder.release_a_working_bike).to be_nil
      end

      it "should release a broken bike, if it has one" do
        bike.break
        holder.dock(bike)
        expect(holder.release_a_broken_bike).to eq(bike)
      end

      it "should not release a broken bike, if has none" do
        holder.dock(bike)
        expect(holder.release_a_broken_bike).to be_nil
      end

      it "should release multiple working bikes" do
        holder.dock_all(bikes)
        expect(holder.release_all_working_bikes.count).to eq(2)
      end

      it "should release multiple broken bikes" do
        bikes.each { |bike| bike.break }
        holder.dock_all(bikes)
        expect(holder.release_all_broken_bikes.count).to eq(2)
      end

      it "should not accept something that is can't be broken" do
        expect(holder.bike_count).to eq(0)
        holder.dock("Not a Bike")
        expect(holder.bike_count).to eq(0)
      end

      it "should know when it's full" do
        expect(holder).not_to be_full
        fill_holder(holder)
        expect(holder).to be_full
      end

      it "should know when it's empty" do
        expect(holder).to be_empty
      end

      it "should not accept a bike if it's full" do
        fill_holder(holder)
        expect(holder).to be_full
        holder.dock(bike)
        expect(holder.bike_count).to eq(holder.capacity)
      end

      it "should not be able to release a working bike if empty" do
        expect(holder).to be_empty
        expect(holder.release_a_working_bike).to be_nil
      end

      it "should provide the list of available bikes" do
        working_bike, broken_bike = Bike.new, Bike.new
        broken_bike.break
        holder.dock(working_bike)
        holder.dock(broken_bike)
        expect(holder.available_bikes).to eq([working_bike])
      end

      it "should provide the list of broken bikes" do
        working_bike, broken_bike = Bike.new, Bike.new
        broken_bike.break
        holder.dock(working_bike)
        holder.dock(broken_bike)
        expect(holder.broken_bikes).to eq([broken_bike])
      end

    end
