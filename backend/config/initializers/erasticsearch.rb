Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: "https://elastic:#{ENV["ELASTIC_PASSWORD"]}@localhost:9200",
  transport_options: {
    ssl: {
      ca_file: 'config/certs/elastic-cert.crt',
      verify: false
    }
  }
)
