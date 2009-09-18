class Hash
  
  # Utility Hashmap extractor method. Gets subset of hash map into a new hashmap Used for
  # Page.#spray pattern. adapted from:
  # http://www.matthewbass.com/blog/2007/03/05/select-all-hash-keyvalue-pairs-matching-a-set-of-keys/
  # 
  #     dict = {:a, 'a',:b, 'b',:c, 'c',:d, 'd'}
  #     dict.pluck(:a, :c)
  #     returns {:a, 'a', :c, 'c'}
  # Implementation simply rejects the keys if they were not passed. You end up only with the subset
  # specified. Nice metaprogramming stuff. The core Hash.fetch method(key) returns only the value of
  # the key passed but we need to pluck out subset key-value pairs from the hash. At present Ruby
  # doesn't have such a method builtin but thanks to open classes we can add it at runtime. see also
  # Hash.update that adds and updates key, value pairs#
  def pluck(*args)
    reject { |k, v| !args.include?(k.to_sym) }
  end
end
