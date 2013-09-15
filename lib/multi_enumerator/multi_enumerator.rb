class MultiEnumerator::MultiEnumerator < Enumerator

  attr_reader :enums

  # @param [Enumerator, ...] enums List of enumerators
  # @param [Hash] options
  # @option options [Boolean] :rewind Indicates whether enumerators should be rewound before traversal. Defaults to the +true+.
  # @option options [Object] :ljust_with Object for filling tails. Defaults to the corresponding +StopIteration+ exception.
  def initialize(*args)
    @options = args.last.is_a?(::Hash) ? args.pop : {}
    @options[:rewind] = true unless @options.key?(:rewind)
    @enums = args.flatten.freeze
  end

  # @yield [a, b, c, ...] items from the corresponding enumerators
  def each
    return to_enum(:each) unless block_given?

    @enums.each(&:rewind) if @options[:rewind]

    loop do
      entry = @enums.map do |enum|
        begin
          enum.next
        rescue => ex
          ex
        end
      end

      break if entry.all?{|item| item.is_a? ::StopIteration }

      if @options.key?(:ljust_with)
        entry.map!{|item| item.is_a?(::StopIteration) ? @options[:ljust_with] : item }
      end

      yield *entry
    end

    self
  end

  def inspect
    "#<#{self.class.name}: #{@enums.inspect}>"
  end
end
