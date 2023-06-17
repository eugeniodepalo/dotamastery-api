ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.plural /^(hero)$/i, '\1es'
end
