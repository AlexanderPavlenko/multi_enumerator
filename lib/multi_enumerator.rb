require 'multi_enumerator/version'
require 'multi_enumerator/multi_enumerator'

module MultiEnumerator
  def self.build(*args)
    MultiEnumerator.new(*args)
  end
end
