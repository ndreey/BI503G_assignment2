#!/usr/bin/env nextflow
params.cutoff = 30

process getSeq {
  input:
    path fasta_file 
    val cutoff
  output:
    path 'output.txt'
  script:
    """
      #!/usr/bin/env python3
      from Bio import SeqIO      
      
      with open('output.txt', 'a') as writer:
          with open("$fasta_file") as fasta_io:
              for record in SeqIO.parse(fasta_io, 'fasta'):
                  if len(record.seq) > $cutoff:
                      writer.write(f">{record.id}\\n{record.seq}\\n")
    """
}
  
workflow {
  fileName = Channel.fromPath(params.inputFile)

  filteredData = getSeq(fileName, params.cutoff)
}
