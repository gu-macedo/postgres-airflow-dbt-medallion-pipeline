import kagglehub

destination = "./data"

path = kagglehub.dataset_download(
    handle="olistbr/brazilian-ecommerce",
    output_dir=destination)

print(f"new files saved in: {path}")