arr00=(0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
arr01=(0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
arr02=(0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
arr03=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
arr04=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
arr05=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
arr06=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
arr07=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
arr08=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
arr09=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
arr1=('arr00[@]' 'arr01[@]' 'arr02[@]' 'arr03[@]' 'arr04[@]' 'arr05[@]' 'arr06[@]' 'arr07[@]' 'arr08[@]' 'arr09[@]')
arr=('arr1[@]')

function print_grid {
    arr=$1
    for elmv1 in "${arr[@]}"; do
        for elmv2 in "${!elmv1}"; do
            for elm in "${!elmv2}"; do
                echo -n "$elm"
            done
            echo
        done
    done
}

print_grid $arr

# |Bash|3.2.57|[Site](https://www.gnu.org/software/bash/)|
# bash conway.sh
