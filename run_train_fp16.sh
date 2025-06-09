export HIP_VISIBLE_DEVICES=5
export CUDA_VISIBLE_DEVICES=5

export PYTHONPATH=${PWD}:${PYTHONPATH}
## normal config
CONFIG=${PWD}/projects/configs/maptrv2/maptrv2_nusc_r50_24ep.py 
WORK_DIR=${PWD}/work_dirs
## profile config
# CONFIG=${PWD}/projects/configs/maptrv2/maptrv2_nusc_r50_24ep-profile.py 
# WORK_DIR=${PWD}/profiler_logs

## for collect miopen & hipblaslt info
# export MIOPEN_ENABLE_LOGGING_CMD=1
# export HIPBLASLT_LOG_MASK=64
# export HIPBLASLT_LOG_FILE=perf_ana/hipblaslt_mask64_iter5_%i.log
# CONFIG=${PWD}/projects/configs/maptrv2/maptrv2_nusc_r50_24ep-iter.py 
# WORK_DIR=${PWD}/work_dirs
# export CUDA_VISIBLE_DEVICES=4,5,6,7
#export TORCH_BLAS_PREFER_HIPBLASLT=1  export ROCBLAS_USE_HIPBLASLT=1
HIPBLASLT_TUNING_OVERRIDE_FILE=dump_tuning.txt ./tools/fp16/dist_train.sh $CONFIG 1 --work-dir ${WORK_DIR} # 2>&1 | tee perf_ana/miopen_raw_info_1iter.log

#WORK_DIR=${PWD}/profiler_logs
#TRACE_JSON=${WORK_DIR}/dl-server-h20_11229.1745496116020.pt.trace.json.gz
#PERF_XLSX=${WORK_DIR}/maptr-v2-batch4-h20.xlsx
#python TraceLens/examples/generate_perf_report.py --profile_path ${TRACE_JSON} --output_xlsx_path ${PERF_XLSX}
