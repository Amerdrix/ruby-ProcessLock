require_relative 'locked_error'
module ProcessLock
  class NixLocker
    EXISTS = :a5e82ab0b5ba11e3a5e20800200c9a66

    def lock(name)
      path = File.join(tmpdir, name + ".pid")
      result = run(path)

      raise LockedError if result == EXISTS
      result
    end

    private

    def run(path)
      catch(EXISTS) do
        begin
          begin
            File.open(path, File::WRONLY|File::CREAT|File::EXCL) do |file|
              file << Process.pid
            end
          rescue
            throw(EXISTS, EXISTS)
          end

          yield

        ensure
          File.delete(path)
        end
      end
    end
  end
end
