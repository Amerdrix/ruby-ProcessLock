require "ProcessLock/version"
require "ProcessLock/locked_error"
require "ProcessLock/nix_locker"

module ProcessLock
  class << self
    def ensure_only_process(name = nil, &block)
      raise ArgumentError, "No block given" unless block_given?
      name ||= infer_name(block)
      locker = NixLocker.new
      locker.ensure_only_process(name, &block)
    end

    private

    def infer_name(block)
      method = block.binding.eval('__method__')
      file = File.basename(block.binding.eval('__FILE__'), '.*')
      "#{file}-#{method}"
    end
  end
end
