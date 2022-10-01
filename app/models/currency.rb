class Currency < ApplicationRecord
  IGNORED_CURRENCIES = %w[
    VEF_BLKMKT VEF_DICOM VEF_DIPRO
    XAG XAU XCD XDR XMR XOF XPD XPF XPT XRP
  ].freeze

  paginates_per 10
  
  scope :sorted, -> { order(:iso) }

  validates :iso, presence: true, exclusion: { in: IGNORED_CURRENCIES }
  validates :name, presence: true
  validates :rate, presence: true
end
