package com.bucketoperations.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.api.client.googleapis.auth.clientlogin.ClientLogin.Response;
import com.google.api.client.http.InputStreamContent;
import com.google.api.services.storage.Storage;
import com.google.api.services.storage.model.Bucket;
import com.google.api.services.storage.model.ObjectAccessControl;
import com.google.api.services.storage.model.Objects;
import com.google.api.services.storage.model.StorageObject;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Controller
public class OperationsController {

    static String BUCKET_NAME = "";
    @RequestMapping(value="/bucketlist.jsp", method=RequestMethod.POST)
    public ModelAndView getbucketListOperation(@RequestParam("bucket-name") String bucketName, HttpServletRequest request,
            HttpServletResponse response) {
        String message = "";
        try {
            List<StorageObject> objects = listBucket(bucketName);
            List<Map<String, Object>> itemsList = new LinkedList<Map<String, Object>>();

            for(StorageObject object : objects) {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("fileName", object.getName());
                map.put("size", object.getSize());
                map.put("type",object.getContentType());
                map.put("lastModified", object.getUpdated());
                itemsList.add(map);
            }

            BUCKET_NAME = bucketName;
            request.setAttribute("itemsList", itemsList);
            request.setAttribute("bucketName", bucketName);
        }
        catch(Exception e) {
            e.printStackTrace();
            return new ModelAndView("bucketlist", "message", null);
        }
        return new ModelAndView("bucketlist", "message", message);
    }

    public static List<StorageObject> listBucket(String bucketName)
            throws IOException, GeneralSecurityException {
        Storage client = StorageFactory.getService();
        Storage.Objects.List listRequest = client.objects().list(bucketName);

        List<StorageObject> results = new ArrayList<StorageObject>();
        Objects objects;
        do {
            objects = listRequest.execute();
            results.addAll(objects.getItems());
            listRequest.setPageToken(objects.getNextPageToken());
        } while (null != objects.getNextPageToken());

        return results;
    }

    @RequestMapping(value="/delete.jsp", method=RequestMethod.POST)
    public static ModelAndView deleteItemFromBucket(@RequestParam("fileName") String fileName) throws IOException, GeneralSecurityException {
        deleteObject(fileName, BUCKET_NAME);
        System.out.println(fileName + " is deleted");
        return new ModelAndView("delete","fileName", fileName);
    }

    public static void deleteObject(String path, String bucketName)
            throws IOException, GeneralSecurityException {
        Storage client = StorageFactory.getService();
        client.objects().delete(bucketName, path).execute();
    }

    @RequestMapping(value="/bucketlist-form.jsp")
    public static ModelAndView getBucketListForm() {
        return new ModelAndView("bucketlist-form");
    }

    @RequestMapping(value="/download-item.jsp", method=RequestMethod.GET)
    public static ModelAndView downloadItemFromBucket(@RequestParam("fileName") String fileName) throws IOException, GeneralSecurityException {
        String filePath = System.getProperty("user.home") + "\\" + fileName;
        downloadItem(BUCKET_NAME, fileName, filePath);
        return new ModelAndView("download-item", "filePath", filePath);
    }

    public static void downloadItem(String bucketName, String fileName, String filePath) throws IOException, GeneralSecurityException {
        Storage client = StorageFactory.getService();
        Storage.Objects.Get getObject = client.objects().get(bucketName, fileName);
        FileOutputStream fos = new FileOutputStream(new File(filePath));
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        getObject.getMediaHttpDownloader().setDirectDownloadEnabled(true);
        getObject.executeMediaAndDownloadTo(out);

        if(out != null) {
            out.writeTo(fos);
        }
        fos.close();
        out.close();
        return;
    }
    @RequestMapping(value="/upload-file.jsp")
    public static ModelAndView uploadFileForm() {
        return new ModelAndView("upload-file");
    }

    @RequestMapping(value="/upload-normal-file.jsp", method=RequestMethod.POST)
    public static ModelAndView uploadFileNormally(@RequestParam("uploadFile") MultipartFile file, @RequestParam("fileName") String fileName) throws IOException, GeneralSecurityException {

        if(!fileName.contains(".")) {
            System.out.println("The filename has no extension or the file is not valid");
        }

        else {
            String parts[] = fileName.split("\\.");
            String prefix = parts[0];
            String suffix = parts[1];

            if(prefix.contains("\\")) {
                parts = prefix.split("\\\\");
                prefix = parts[parts.length - 1];
            }
            else if(prefix.contains("/")) {
                parts = prefix.split("/");
                prefix = parts[parts.length - 1];
            }

            fileName = prefix + "." + suffix;
            Path tempPath = Files.createTempFile(prefix, suffix);
            byte array[] = file.getBytes();
            Files.write(tempPath, array);
            File tempFile = tempPath.toFile();
            tempFile.deleteOnExit();
            uploadFile(fileName, "text/plain", tempFile, "ngs_data_upload_bucket");
        }

        return new ModelAndView("upload-normal-file");
    }

    public static void uploadFile(
            String name, String contentType, File file, String bucketName)
                    throws IOException, GeneralSecurityException {
        InputStreamContent contentStream = new InputStreamContent(
                contentType, new FileInputStream(file));
        contentStream.setLength(file.length());
        StorageObject objectMetadata = new StorageObject()
                .setName(name)
                .setAcl(Arrays.asList(
                        new ObjectAccessControl().setEntity("allUsers").setRole("READER"))).set("uploadType","media");

        Storage client = StorageFactory.getService();
        Storage.Objects.Insert insertRequest = client.objects().insert(
                bucketName, objectMetadata, contentStream);

        insertRequest.execute();
    }
}