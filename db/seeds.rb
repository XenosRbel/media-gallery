# frozen_string_literal: true

puts "Импорт исходных данных. Это займет много времени..."

::MediaGallery::Folder.create(name: "General", system_name: "General")
