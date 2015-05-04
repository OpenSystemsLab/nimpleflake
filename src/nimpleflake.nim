from times import epochTime
from math import random, randomize

const
  DEFAULT_EPOCH = 1420070400  ## Epoch for nimpleflake timestamps, starts at the year 2015

  #field lengths in bits
  TIMESTAMP_LENGTH = 41
  RANDOM_LENGTH = 23

  #left shift amounts
  RANDOM_SHIFT = 0
  TIMESTAMP_SHIFT = 23

randomize()

proc getrandbits(k: int): int =
  for i in 0..k:
    var f = int(random(DEFAULT_EPOCH))
    if f mod 2 != 0:
      result = result or (1 shl (i %% 64))

proc nimpleflake*(timestamp: int = 0, random_bits: int = 0, epoch = DEFAULT_EPOCH): int =
  var second_time = if timestamp > 0: timestamp else: int(epochTime())
  second_time -= epoch
  var millisecond_time = second_time * 1000

  var random_bits = random_bits
  if random_bits == 0:
    random_bits = getrandbits(RANDOM_LENGTH)

  (millisecond_time shl TIMESTAMP_SHIFT) + random_bits

when isMainModule:
  echo nimpleflake()
