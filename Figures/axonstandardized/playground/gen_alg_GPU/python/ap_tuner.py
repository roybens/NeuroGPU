import numpy as np

def thereshold_volt(target, data, dt=0.02, stims = None, index = None):
	def thereshold_volt_helper(volts, dt):
		if max(volts) > 0:
			try:
				volts = np.array(volts)
				volts_grad = np.gradient(volts)
				volts_sec_grad = np.gradient(volts_grad)
				i_60 = np.argmax(volts > -60)
				i_40 = np.argmax(volts > -40)
				i_threshold = i_60 + np.argmax(volts_sec_grad[i_60:i_40])
				return volts[i_threshold]
			except:
				return 0
		else:
			return 0
	return (thereshold_volt_helper(target, dt) - thereshold_volt_helper(data, dt))**2

def first_hump_speed(target, data, dt=0.02, stims = None, index = None):
	def first_hump_speed_helper(volts, dt):
		if max(volts) > 0: 
			try:
				volts = np.array(volts)
				volts_grad = np.gradient(volts)
				volts_sec_grad = np.gradient(volts_grad)
				i_60 = np.argmax(volts > -60)
				i_40 = np.argmax(volts > -40)	
				i_threshold = i_60 + np.argmax(volts_sec_grad[i_60:i_40])
				i_second_hump = np.argmax(volts_grad)
				i_first_hump = i_threshold + \
							   np.argmin(volts_grad[i_threshold:i_second_hump])
				return volts_grad[i_first_hump]
			except:
				return 0
		else:
			return 0
	return (first_hump_speed_helper(target, dt) - first_hump_speed_helper(data, dt))**2

def first_hump_volt(target, data, dt=0.02, stims = None, index = None):
	def first_hump_volt_helper(volts, dt):
		if max(volts) > 0: 
			try:
				volts = np.array(volts)
				volts_grad = np.gradient(volts)
				volts_sec_grad = np.gradient(volts_grad)
				i_60 = np.argmax(volts > -60)
				i_40 = np.argmax(volts > -40)
				i_threshold = i_60 + np.argmax(volts_sec_grad[i_60:i_40])
				i_second_hump = np.argmax(volts_grad)
				i_first_hump = i_threshold + \
							   np.argmin(volts_grad[i_threshold:i_second_hump])
				return volts[i_first_hump]
			except:
				return 0
		else:
			return 0
	return (first_hump_volt_helper(target, dt) - first_hump_volt_helper(data, dt))**2

def second_hump_speed(target, data, dt=0.02, stims = None, index = None):
	def second_hump_speed_helper(volts, dt):
		if max(volts) > 0:
			try:
				volts = np.array(volts)
				volts_grad = np.gradient(volts)
				i_second_hump = np.argmax(volts_grad)
				return volts_grad[i_second_hump]
			except:
				return 0
		else:
			return 0
	return (second_hump_speed_helper(target, dt) - second_hump_speed_helper(data, dt))**2

def second_hump_volt(target, data, dt=0.02, stims = None, index = None):
	def second_hump_volt_helper(volts, dt):
		if max(volts) > 0: 
			try:
				volts = np.array(volts)
				volts_grad = np.gradient(volts)
				i_second_hump = np.argmax(volts_grad)
				return volts[i_second_hump]
			except:
				return 0
		else:
			return 0
	return (second_hump_volt_helper(target, dt) - second_hump_volt_helper(data, dt))**2

def max_volt(target, data, dt=0.02, stims = None, index = None):
	def max_volt_helper(volts, dt):
		if max(volts) > 0: 
			try:
				volts = np.array(volts)
				i_max = np.argmax(volts)
				return volts[i_max]
			except:
				return 0
		else:
			return 0
	return (max_volt_helper(target, dt) - max_volt_helper(data, dt))**2

def fine_tune_ap(target, data, weight, dt=0.02):
	return weight*(thereshold_volt(target, data, dt) + first_hump_speed(target, data, dt) + \
		first_hump_volt(target, data, dt) + second_hump_speed(target, data, dt) + \
		second_hump_volt(target, data, dt) + max_volt(target, data, dt))


