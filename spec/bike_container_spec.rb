    require './lib/bike_container'

    class ContainerHolder; include BikeContainer; end

    describe BikeContainer do

      let(:bike) { Bike.new }
      let(:bikes) {[Bike.new, Bike.new]}
      let(:holder) { ContainerHolder.new }

      def fill_holder(container)
        10.times { container.dock(Bike.new) }
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
        expect(lambda { holder.dock(bike) }).to raise_error(RuntimeError)
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
