module Beatport
  module Client
    def self.client
      @client ||= Signet::OAuth1::Client.new(
        :client_credential_key =>     Beatport.consumer_key,
        :client_credential_secret =>  Beatport.consumer_secret,
        :token_credential_key =>      Beatport.access_token_key,
        :token_credential_secret =>   Beatport.access_token_secret
      )
    end
    
    def self.builder
      @builder ||= Support::QueryBuilder.new
    end
    
    def self.retrieve(path, klass, *args)
      uri = Addressable::URI.new(
        :scheme => 'https',
        :host => 'api.beatport.com',
        :path => "/catalog/3/#{path}",
        :query_values => builder.process(*args)
      )
      
      result = client.fetch_protected_resource(:uri => uri.to_s)
      result = JSON.parse(result.body)

      # underscore result keys
      result = Support::Inflector.process_keys(result) { |k| Support::Inflector.underscore(k) }

      if result['metadata']['error']
        raise Error.new("#{result['metadata']['error']}: #{result['metadata']['message']}")
      end

      case result['results']
      when Array
        if builder.single_result?
          klass.new(result['results'].first) if result['results'].any?
        else
          Collection.new(klass, result)
        end
      when Hash
        klass.new(result['results'])
      else
        raise Error.new("results is an unexpected class #{result['results'].class}")
      end
    end 
  end
end