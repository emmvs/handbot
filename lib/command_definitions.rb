# frozen_string_literal: true

module CommandDefinitions
  # Command sets for different languages
  COMMAND_SETS = {
    'en' => {
      start: '/start',
      help: '/help',
      search: '/search',
      settings: '/settings',
      languages: '/languages'
    },
    'de' => {
      start: '/los_gehts',
      help: '/hilfe',
      search: '/suche',
      settings: '/einstellungen',
      languages: '/sprachen'
    },
    'uk' => {
      start: '/почати',
      help: '/допомога',
      search: '/пошук',
      settings: '/налаштування',
      languages: '/мови'
    },
    'ar' => {
      start: '/ابدأ',
      help: '/مساعدة',
      search: '/بحث',
      settings: '/إعدادات',
      languages: '/لغات'
    },
    'fa' => {
      start: '/شروع',
      help: '/کمک',
      search: '/جستجو',
      settings: '/تنظیمات',
      languages: '/زبان‌ها'
    },
    'tr' => {
      start: '/başlat',
      help: '/yardım',
      search: '/ara',
      settings: '/ayarlar',
      languages: '/diller'
    },
    'fr' => {
      start: '/commencer',
      help: '/aide',
      search: '/recherche',
      settings: '/paramètres',
      languages: '/langues'
    },
    'ru' => {
      start: '/начать',
      help: '/помощь',
      search: '/поиск',
      settings: '/настройки',
      languages: '/языки'
    }
  }.freeze
end
