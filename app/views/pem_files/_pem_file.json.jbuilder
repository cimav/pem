json.extract! pem_file, :id, :email, :status, :key, :cer, :created_at, :updated_at
json.url pem_file_url(pem_file, format: :json)
