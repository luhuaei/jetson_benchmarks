ln:
	sudo ln -sf /usr/src/tensorrt/bin/trtexec /usr/bin/trtexec
	sudo jetson_clocks --fan

pre_resnet50:
	sudo bash install_requirements.sh
	python3 utils/download_models.py --model_name resnet --csv_file benchmark_csv/orin-benchmarks.csv --save_dir benchmark_models

resnet50:
	sudo python3 benchmark.py --model_name resnet --csv_file_path benchmark_csv/orin-benchmarks.csv --model_dir benchmark_models --jetson_clocks --jetson_devkit orin --power_mode 0 --precision fp16 --plot 
	sudo python3 benchmark.py --model_name resnet --csv_file_path benchmark_csv/orin-benchmarks.csv --model_dir benchmark_models --jetson_clocks --jetson_devkit orin --power_mode 0 --precision int8 --plot

pre_yolov8s:
	pip install ultralytics
	yolo mode=export model=yolov8s.pt format=onnx
	python3 rebatch.py yolov8s.onnx benchmark_models/yolov8s-bs32.onnx

yolov8s:
	sudo python3 benchmark.py --model_name yolov8s --csv_file_path benchmark_csv/orin-benchmarks.csv --model_dir benchmark_models --jetson_clocks --jetson_devkit orin --power_mode 0 --precision fp16 --plot
	sudo python3 benchmark.py --model_name yolov8s --csv_file_path benchmark_csv/orin-benchmarks.csv --model_dir benchmark_models --jetson_clocks --jetson_devkit orin --power_mode 0 --precision int8 --plot

zh-clip-text:
	sudo python3 benchmark.py --model_name zh-clip-text --csv_file_path benchmark_csv/orin-benchmarks.csv --model_dir benchmark_models --jetson_clocks --precision none

zh-clip-vision:
	sudo python3 benchmark.py --model_name zh-clip-vision --csv_file_path benchmark_csv/orin-benchmarks.csv --model_dir benchmark_models --jetson_clocks --precision none
