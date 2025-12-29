class univariate():
    
   def quanQual(dataset):
        quan=[]
        qual=[]
        for columnName in dataset.columns:
            #print(columnName)
            if(dataset[columnName].dtype=='O'):
               #print("qual")
               qual.append(columnName)
            else:
                #print("quan")
                quan.append(columnName)
        return quan,qual  

def arithmetic(columnName,dataset):
    descriptive=pd.DataFrame(index=["mean","median","mode"],columns=quan)
    for columnName in quan:
        descriptive[columnName]["mean"]=dataset[columnName].mean()
        descriptive[columnName]["median"]=dataset[columnName].median()
        descriptive[columnName]["mode"]=dataset[columnName].mode()[0]
    return descriptive

    
def quandrant(columnName,dataset):
    descriptive=pd.DataFrame(index=["mean","median","mode","Q1:25%","Q2:50%","Q3:75%","Q4:100%"],columns=quan)
    for columnName in quan:
        descriptive[columnName]["mean"]=dataset[columnName].mean()
        descriptive[columnName]["median"]=dataset[columnName].median()
        descriptive[columnName]["mode"]=dataset[columnName].mode()[0]
        descriptive[columnName]["Q1:25%"]=dataset.describe()[columnName]["25%"]
        descriptive[columnName]["Q2:50%"]=dataset.describe()[columnName]["50%"]
        descriptive[columnName]["Q3:75%"]=dataset.describe()[columnName]["75%"]
        descriptive[columnName]["Q4:100%"]=dataset.describe()[columnName]["max"]
      
    

def univariate(dataset,quan):
    descriptive=pd.DataFrame(index=["mean","median","mode","Q1:25%","Q2:50%","Q3:75%","Q4:100%","IQR","1.5Rule","Lesser","Greater","min","max"],columns=quan)
    for columnName in quan:
        descriptive[columnName]["mean"]=dataset[columnName].mean()
        descriptive[columnName]["median"]=dataset[columnName].median()
        descriptive[columnName]["mode"]=dataset[columnName].mode()[0]
        descriptive[columnName]["Q1:25%"]=dataset.describe()[columnName]["25%"]
        descriptive[columnName]["Q2:50%"]=dataset.describe()[columnName]["50%"]
        descriptive[columnName]["Q3:75%"]=dataset.describe()[columnName]["75%"]
        descriptive[columnName]["Q4:100%"]=dataset.describe()[columnName]["max"]
        descriptive[columnName]["IQR"]=descriptive[columnName]["Q3:75%"]- descriptive[columnName]["Q1:25%"]
        descriptive[columnName]["1.5Rule"]=1.5*descriptive[columnName]["IQR"]
        descriptive[columnName]["Lesser"]=descriptive[columnName]["Q1:25%"]-descriptive[columnName]["1.5Rule"]
        descriptive[columnName]["Greater"]=descriptive[columnName]["Q3:75%"]+descriptive[columnName]["1.5Rule"]
        descriptive[columnName]["min"]=dataset[columnName].min()
        descriptive[columnName]["max"]=dataset[columnName].max()
        
    return descriptive
    
def freqTable(columnName,dataset):
    freqTable=pd.DataFrame(columns=["unique_values","Frequency","Relative_Frequency","cumsum"])
    freqTable["unique_values"]=dataset["ssc_p"].value_counts().index
    freqTable["Frequency"]=dataset["ssc_p"].value_counts().values
    freqTable["Relative_Frequency"]=(freqTable["Frequency"]/105)
    freqTable["cumsum"]=freqTable["Relative_Frequency"].cumsum()
    return freqTable
    