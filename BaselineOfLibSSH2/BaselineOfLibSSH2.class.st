Class {
	#name : 'BaselineOfLibSSH2',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfLibSSH2',
	#package : 'BaselineOfLibSSH2'
}

{ #category : 'baselines' }
BaselineOfLibSSH2 >> baseline: spec [
   <baseline>

	spec for: #'common' do: [
		spec package: #'LibSSH2']
]
