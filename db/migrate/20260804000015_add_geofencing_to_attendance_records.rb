class AddGeofencingToAttendanceRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :attendance_records, :ip_address, :string
    add_column :attendance_records, :latitude, :decimal, precision: 10, scale: 6
    add_column :attendance_records, :longitude, :decimal, precision: 10, scale: 6
  end
end
