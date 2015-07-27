#$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '../'))

require 'httparty'
#require 'idealista/core_extensions/rubify_keys'


module Idealista
  # TODO implement search method as part of idealista module? In addition to 
  # client class, like twitter
  class Client

    include HTTParty
    Hash.include ::CoreExtensions::RubifyKeys
    base_uri "http://idealista-prod.apigee.net/public/2/search"

    def initialize(key = nil)
      raise ArgumentError unless key.is_a? String
      @key = key
    rescue ArgumentError
      raise $!, 'Client must be initialized with Idealista api key as sole argument'
      #shortcut okay?
    end

    def search(query)
      validate_args(query)
      query.unrubify_keys!
      query[:apikey] = @key
      hash = self.class.get('', query: query).parsed_response
      # TODO separate call and dealing with response
      raise StandardError, 'Unexpected idealista response!' unless hash.is_a? Hash
      hash.rubify_keys!
      if hash["fault"] && 
         hash["fault"]["faultstring"].include?('Spike arrest violation')
        # TODO use errorcode instead?
        raise SpikeArrestError, hash["fault"]["faultstring"]
      end
      # TODO deal with different http response body encodings. httparty parses 
      # binary into a hash, not string
      # Seems to work actully, with spike arrest at least
      properties = Property.parse(hash["element_list"])
    end
      # TODO convert response to symbols?

    private

      def validate_args(args)
        # TODO extract into validator class/module??
        # TODO best way? does include? accept hash?
        unless [:property_type, :operation].all? { |e| args.keys.include? e} && 
               ([:center, :address, :phone, :user_code] & args.keys).size == 1
          raise ArgumentError, 'Required attributes: operation, property_type, ' \
                               'and only one of [center, address, phone, user_code]'
        end
      end


  end
end
