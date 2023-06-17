class SyncHeroesTask
  include Task

  def perform
    get_heroes.each do |api_hero|
      hero = Hero.find_or_initialize_by(original_id: api_hero['id'])
      hero.update!(name: api_hero['localized_name'], portrait_url: portrait_url_for(api_hero))
    end
  end

  private

  def get_heroes
    Dota.api.get('IEconDOTA2_570', 'GetHeroes', language: 'en')['result']['heroes'] || raise(Failsafe::RetriableError)
  end

  def portrait_url_for(api_hero)
    "#{Rails.configuration.x.valve_cdn_url}/apps/dota2/images/heroes/#{name_for(api_hero)}_full.png"
  end

  def name_for(api_hero)
    api_hero['name'].sub('npc_dota_hero_', '')
  end
end
