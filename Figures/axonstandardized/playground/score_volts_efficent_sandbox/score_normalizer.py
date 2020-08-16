# @author David Mao, comments and modifications by Maxwell Chen
import numpy as np

# This should take in an array and return 3 things:
#    - the normalized array
#    - the add factor
#    - the divide factor
def normalize_helper(input):
    mini = np.inf                                   # Placeholder values
    maxi = 0                                        # Placeholder values
    total = 0                                       # Placeholder values

    for i in input:
        if (i < mini):
            mini = i                                # find minimum value
        if (i > maxi):
            maxi = i                                # find maximum value
        total += i                                  # add to running total
    average = total/len(input)                      # get average value of input array

    if (maxi == mini):
        return np.array(input), 0, 1, mini, maxi, average                          # one value or all the same values; prevent 0 division

    relativeAverage = (average-mini)/(maxi-mini)    # maxi-mini = range of values. average-mini = average, relative to "start" of range.
    addFactor = 0                                   # (average-mini)/(maxi-mini) gets the relative (normalized) average within the range from mini to maxi
    divideFactor = 1

    realMaxi = maxi                                 # Preserve max of original data
    realMini = mini                                 # Preserve min of original data

    if (relativeAverage >= 0.5):
        addFactor = -mini
        maxi -= mini
        divideFactor = maxi * (relativeAverage / 0.5)
    elif (relativeAverage < 0.5):
        newMin = (0.5 - relativeAverage)/(1 - relativeAverage)
        addFactor = -mini
        maxi -= mini
        addFactor += maxi * newMin/(1 - newMin)
        divideFactor = maxi + addFactor + mini

    output = []
    for i in input:
        output.append((i + addFactor)/divideFactor)                             # perform min-max normalization

    return np.array(output), addFactor, divideFactor, realMini, realMaxi, average       # return all values

def normalize(raw_input, bottomFraction = 0.95, numStds = 4):
    #bottomFraction is the bottom amount of values we want to be comparing to
    #numStds is the number of standard deviations we want to keep
    input = raw_input.T[0]
    sortedList = input.copy()                                                   # Copy input
    sortedList.sort()                                                           # Sort copied values
    lowestxPercent = sortedList[:(int)(len(sortedList) * bottomFraction)]       # Take values in the bottomFraction of the list (lowest 95% of values)
    newMean = sum(lowestxPercent)/len(lowestxPercent)                           # calculate average of this range of values
    std = np.std(lowestxPercent)                                                # get standard deviation (std)

    newMax = newMean + numStds * std                                            # find new max based on numStds
    newArray = []
    numCapped = 0
    for i in input:
        if (i > newMax):                                                        # if value in original input is larger than the average of the sublist
            newArray.append(newMax)                                             # too big; rail to ceiling value
            numCapped += 1                                                      # inc. counter by 1. I think this is extraneous (not used afterwards)
        else:
            newArray.append(i)                                                  # value is within sorted range; keep the value

    #95%, numStandard deviations, average of bottom 95%, standard deviation of 95%, newMax
    transformation = [bottomFraction, numStds, newMean, std, newMax]                                   # metadata
    normalized_score, addFactor, divideFactor, mini, maxi, average = normalize_helper(newArray)        # run helper to normalize the list (capped to bottom 95% of input)
    transformation += [addFactor, divideFactor, mini, maxi, average]
    normalized_score = normalized_score[np.newaxis].T                                   # concatenate addFactor and divideFactor
    return np.array(normalized_score), np.array(transformation)                                                            # return normalized list and metadata



