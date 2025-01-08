ln:
	sudo ln -sf /usr/src/tensorrt/bin/trtexec /usr/bin/trtexec
	sudo jetson_clocks --fan

pre_resnet50:
	mkdir -p resnet50
	python3 utils/download_models.py --model_name resnet --csv_file benchmark_csv/orin-benchmarks.csv --save_dir benchmark_models

resnet50:
	sudo python3 benchmark.py --model_name resnet --csv_file_path benchmark_csv/orin-benchmarks.csv --model_dir benchmark_models --jetson_clocks --jetson_devkit orin --power_mode 0 --precision fp16
	sudo python3 benchmark.py --model_name resnet --csv_file_path benchmark_csv/orin-benchmarks.csv --model_dir benchmark_models --jetson_clocks --jetson_devkit orin --power_mode 0 --precision int8
