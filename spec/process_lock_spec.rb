require_relative '../lib/process_lock'
require_relative '../lib/ProcessLock/locked_error'

describe ProcessLock do
  describe '.ensure_only_process' do

    specify 'raises an error when a block is not passed' do
      expect { ProcessLock.ensure_only_process }.to raise_error(ArgumentError)
    end

    specify 'raises an error when run simultaneously' do
      expect { ProcessLock.ensure_only_process { ProcessLock.ensure_only_process {} } }.to raise_error(ProcessLock::LockedError)
    end

    specify 'raises an error raised by the block' do
      exp = Exception.new
      expect { ProcessLock.ensure_only_process { raise exp } }.to raise_error(exp)
    end

    specify 'does not raise an error when running when a block is passed' do
      expect { ProcessLock.ensure_only_process {} }.to_not raise_error
    end

    specify 'does not raise an error when run twice in a row' do
      ProcessLock.ensure_only_process {}
      expect { ProcessLock.ensure_only_process {} }.to_not raise_error
    end

    specify 'return the result of the block' do
      result = Object.new
      expect(ProcessLock.ensure_only_process { result }).to be result
    end
  end
end

