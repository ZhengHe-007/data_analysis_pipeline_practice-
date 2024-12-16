# Default target
.PHONY: all clean test

all: results/word_count.txt results/plot_count.png report/count_report.html

# Word count analysis
results/word_count.txt: data/abyss.txt scripts/wordcount.py
	@echo "Running word count analysis..."
	mkdir -p results
	python3 scripts/wordcount.py --input data/abyss.txt --output results/word_count.txt
	@echo "Word count analysis completed."
	
# Plot count analysis
results/plot_count.png: data/abyss.txt scripts/plotcount.py
	@echo "Running plot count analysis..."
	mkdir -p results
	python3 scripts/plotcount.py data/abyss.txt results/plot_count.png
	@echo "Plot count analysis completed."

# Generate the report
report/count_report.html: report/count_report.qmd results/word_count.txt results/plot_count.png
	@echo "Rendering analysis report..."
	mkdir -p report
	quarto render report/count_report.qmd --to html
	@echo "Report generated: report/count_report.html"

# Clean up intermediate and output files
clean:
	@echo "Cleaning up generated files..."
	rm -rf results/*.txt results/*.png report/count_report.html
	@echo "Clean-up completed."

# Test pipeline scripts
test:
	@echo "Running test scripts..."
	python3 scripts/wordcount.py data/abyss.txt
	python3 scripts/plotcount.py data/abyss.txt results/plot_test.png
	rm -f results/plot_test.png
	@echo "Tests passed successfully!"
