class MountJob
  require 'fileutils'
  @queue = :mount

  def self.perform
    puts "**** Performing Mount ****"

    cmd = "mount -t cifs //pierres-mbp.home/STORAGE /app/public/storage -o username=pierreprevoteau,password=FREEfree2121"
    system cmd

    sleep 360
  end
end
