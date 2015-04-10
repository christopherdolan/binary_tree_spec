require './binary_tree'

describe BinaryTree::Node do
  describe 'initialize' do
    it 'can be initialized' do
      @tree = BinaryTree::Node.new 0
      expect(@tree).to be_an_instance_of BinaryTree::Node
    end

    it 'begins with empty leaf nodes' do
      @tree = BinaryTree::Node.new 0
      expect(@tree.left).to be_an_instance_of BinaryTree::EmptyNode
      expect(@tree.right).to be_an_instance_of BinaryTree::EmptyNode
    end

    describe '.push' do
      before do
        @tree = BinaryTree::Node.new(5)
      end

      it 'adds smaller values to the left' do
        @tree.push 4
        expect(@tree.left.value).to eq(4)
        @tree.push 3
        expect(@tree.left.left.value).to eq(3)
      end

      it 'adds larger values to the right' do
        @tree.push 6
        expect(@tree.right.value).to eq(6)
        @tree.push 7
        expect(@tree.right.right.value).to eq(7)
      end

      it 'adds no unnecessary nodes' do
        @tree.push 5
        expect(@tree.value).to eq(5)
        expect(@tree.left).to be_an_instance_of BinaryTree::EmptyNode
        expect(@tree.right).to be_an_instance_of BinaryTree::EmptyNode
      end
    end

    describe '.to_a' do
      before do
        @tree = BinaryTree::Node.new(500)
        @test_array = (1..1000).to_a.sort_by{rand} # fails at 10000 (stack level too deep)
        @test_array.each do |val|
          @tree.push val
        end
      end

      it 'returns a sorted data set' do
        @sorted_test_array = @test_array.sort
        expect(@tree.to_a & @sorted_test_array).to eq(@sorted_test_array)
      end

      it 'returns an array with no duplicates' do
        expect(@tree.to_a.uniq).to eq(@tree.to_a)
      end
    end

    describe '.include?' do
      before do
        @tree = BinaryTree::Node.new 1
        @tree.push 4
        @tree.push 32
      end

      it 'returns true when a value exists' do
        expect(@tree.include?(1)).to be true
        expect(@tree.include?(4)).to be true
        expect(@tree.include?(32)).to be true
      end

      it 'returns false when a value does not exist' do
        expect(@tree.include?(-5)).to be false
        expect(@tree.include?(164)).to be false
      end
    end

  end
end
