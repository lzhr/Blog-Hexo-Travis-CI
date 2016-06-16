require 'travis'

Travis.access_token = "3oBnwVWRP0feUjtUQFGNVQ"
puts "Hello #{Travis::User.current.name}!"

rails = Travis::Repository.find('lzhr/Blog-Hexo-Travis-CI')
puts "oh no" unless rails.green?

rails.last_build.restart
