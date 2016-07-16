class AddElectrochemistryThermochemistryKineticsImf < ActiveRecord::Migration
  def change
    add_column :attachments, :electrochemistry, :boolean
    add_column :attachments, :thermochemistry, :boolean 
    add_column :attachments, :kinetics, :boolean 
    add_column :attachments, :intermolecularForces, :boolean 
  end
end
