class RenameResourcesToSources < ActiveRecord::Migration[7.1]
  def change
    rename_table :resources, :sources
  end
end
