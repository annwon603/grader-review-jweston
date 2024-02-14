CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area
rm -rf git-output.txt

mkdir grading-area

git clone $1 student-submission 8> git-output.txt
echo 'Finished cloning'

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

#Checking for files to test in directory
if [[ -f student-submission/ListExamples.java ]]
then
    cp student-submission/ListExamples.java grading-area/
    cp TestListExamples.java grading-area/
else
    echo "Missing student-submission/ListExamples.java, did you forget the file or misname it?"
    exit 1
fi

#see the directory and cd into grading then see if it worked
pwd
cd grading-area
pwd

#comples code
javac -cp $CPATH *.java

#check for comple errors
if [[ $? -ne 0 ]];
then
    echo "The program failed to comple, see compile error above"
    exit 1
fi

#run the tester with Junit
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

lastline = $(cat grading/junit.output.txt | tail -n 2 | head -n)1 
tests=$(echo $lastline |awk -F '[, ]' '{print $3}')
failures=$(echo $lastline | awk -F '(, )' '{print $6}')
sucesses=$((tests-failures))
echo "your score is $sucesses / $tests
