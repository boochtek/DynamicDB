if defined?(Footnotes) && Rails.env.development?
  Footnotes.run! # first of all

  # ... other init code
      require 'footnotes/current_user_note'
      require 'footnotes/global_constants_note'
      Footnotes::Filter.notes -= [:general] # I don't see the point of this note.
      Footnotes::Filter.notes += [:current_user, :global_constants] # Add our custom note.
end
