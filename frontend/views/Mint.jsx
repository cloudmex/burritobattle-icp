import React, { useCallback, useContext, useEffect, useState } from "react";
import {
  Button,
  FormControl,
  FormLabel,
  Box,
  Image,
  Center,
  Flex,
  Input,
  Grid,
  GridItem,
  useColorModeValue,
  Badge,
  Alert,
  AlertIcon,
  AlertTitle,
  AlertDescription,
} from '@chakra-ui/react';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import { gotchi } from "../../.dfx/local/canisters/gotchi";
import { useBalance, useWallet, useTransfer } from "@connect2ic/react";
import { ToastContainer, toast } from 'react-toastify';

export default function Mint({ stateChanger, ...rest }) {
  const [wallet] = useWallet();
  const [assets] = useBalance();
  const [transfer] = useTransfer({
    to: "bc655a7499d30c5d058e01f252a4f8b1ff443c8afa85090cadc71115a6c88e9c",
    amount: Number(0.001)
  });
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [load, setLoad] = useState(false);
  const handleNameChange = (e) => setName(e.target.value);
  const handleDescriptionChange = (e) => setDescription(e.target.value);
  const backgroundColor = useColorModeValue('white', 'gray.800');

  async function mintGotchi() {
    // Verificar si tiene balance la cuenta
    setTimeout(async () => {
      const ICPs = assets.filter(a => a.symbol == "ICP")[0];
      if (ICPs.amount > Number(0.001)) {
        let principal_id = wallet.principal;
        const { height } = await transfer();

        const metadata = {
          name: name,
          description: description
        };

        const new_token = await gotchi.mintGotchi(principal_id, metadata);
        toast("Gotchi minado con éxito");
        setTimeout(() => {
          stateChanger('gotchis');
        }, 1000);

      } else {
        toast("No tienes fondos suficientes");
      }
    }, 1000);
  }

  return (
    <Center>
      <>
        <ToastContainer
          position="top-right"
          autoClose={5000}
          hideProgressBar={false}
          newestOnTop={false}
          closeOnClick
          rtl={false}
          pauseOnFocusLoss
          draggable
          pauseOnHover
          theme="colored"
        />
        <Grid>
          <FormControl>
            <FormLabel><b>Nombre</b></FormLabel>
            <Input type='text' value={name} onChange={handleNameChange} />
          </FormControl><br></br>
          <FormControl>
            <FormLabel><b>Descripción</b></FormLabel>
            <Input type='text' value={description} onChange={handleDescriptionChange} />
          </FormControl><br></br>
          <Button
            mt={4}
            colorScheme='teal'
            type='submit'
            onClick={async () => { mintGotchi(); }}
          >
            Minar
          </Button>
        </Grid>
      </>
    </Center>
  )

}
