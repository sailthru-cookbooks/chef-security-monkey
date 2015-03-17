apt_repository 'dart' do
  uri          'https://storage.googleapis.com/download.dartlang.org/linux/debian'
  arch         'amd64'
  distribution 'trusty'
  components   ['main']
  key          ' https://dl-ssl.google.com/linux/linux_signing_key.pub'
end

package dart
