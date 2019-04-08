# Since bash 4.3
# As of 2016, modern bash supports pass-by-reference (a.k.a nameref attribute) as:

demo_multiple_arrays() {
  local -n _array_one=$1
  local -n _array_two=$2
  printf '1: %q\n' "${_array_one[@]}"
  printf '2: %q\n' "${_array_two[@]}"
}

array_one=( "one argument" "another argument" )
array_two=( "array two part one" "array two part two" )

demo_multiple_arrays array_one array_two
# See also declare -n in the man page.

# Before bash 4.3
# This can be done safely by using a calling convention which puts number-of-arguments before each array, as such:

demo_multiple_arrays() {
  declare -i num_args array_num;
  declare -a curr_args;
  while (( $# )) ; do
    curr_args=( )
    num_args=$1; shift
    while (( num_args-- > 0 )) ; do
      curr_args+=( "$1" ); shift
    done
    printf "$((++array_num)): %q\n" "${curr_args[@]}"
  done
}
# This can then be called as follows:

array_one=( "one argument" "another argument" )
array_two=( "array two part one" "array two part two" )
demo_multiple_arrays \
  "${#array_one[@]}" "${array_one[@]}" \
  "${#array_two[@]}" "${array_two[@]}"
