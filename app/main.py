from fastapi import FastAPI

app = FastAPI(title="FASHSYST Enquiry API")


@app.get("/health")
def health():
    return {"status": "ok"}