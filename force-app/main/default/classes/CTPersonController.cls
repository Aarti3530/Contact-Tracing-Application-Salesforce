public class CTPersonController {
    
    //generate unique hash using MD5 algorithm
    public static String getToken(String mobileNo){

        Blob targetBlob = Blob.valueOf(mobileNo);
        Blob hash = Crypto.generateDigest('MD5', targetBlob);

        return EncodingUtil.base64Encode(hash);
    }

}