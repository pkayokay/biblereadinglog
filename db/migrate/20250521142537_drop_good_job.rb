class DropGoodJob < ActiveRecord::Migration[7.2]
  def change
    drop_table :good_jobs
    drop_table :good_job_batches
    drop_table :good_job_executions
    drop_table :good_job_processes
    drop_table :good_job_settings
  end
end
