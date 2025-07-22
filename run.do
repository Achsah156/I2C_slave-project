vlib work
vlog i2c_slave_test.v +acc
vsim I2C_TOP_test -l run.log
add wave -r *
run -all
