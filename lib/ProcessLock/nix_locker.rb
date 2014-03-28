require 'SecureRandom'
require_relative 'locked_error'

module ProcessLock
  class NixLocker

    EXISTS = Object.new

    def ensure_only_process(name)
      path = File.join(tmpdir, "#{name}.pid")
      result = run(path) { yield }
      raise LockedError if result == EXISTS
      result
    end

    private

    def tmpdir
      '/tmp'
    end

    def run(path)
      thrown = false
      catch(EXISTS) do
        begin
          begin
            File.open(path, File::WRONLY|File::CREAT|File::EXCL) do |file|
              file << Process.pid
            end
          rescue
            thrown = true
            throw(EXISTS, EXISTS)
          end

          yield

        ensure
          File.delete(path) unless thrown
        end
      end
    end
  end
end
